Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269184AbRIBVDg>; Sun, 2 Sep 2001 17:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269238AbRIBVD0>; Sun, 2 Sep 2001 17:03:26 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:3493 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S269184AbRIBVDL>;
	Sun, 2 Sep 2001 17:03:11 -0400
Date: Sun, 02 Sep 2001 22:03:24 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Message-ID: <1039609007.999468203@[169.254.198.40]>
In-Reply-To: <20010902201748Z16294-32383+3038@humbolt.nl.linux.org>
In-Reply-To: <20010902201748Z16294-32383+3038@humbolt.nl.linux.org>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +                     addfront = ( !test_bit((index^1)<<1, (area-1)->map)
> +                                  && !test_bit((index^1)<<1,
					                (area-1) -> map) );

Ooops, that second one should be

> +                                  && !test_bit((index^1)<<1 | 1,
> +					                (area-1) -> map) );


--
Alex Bligh
