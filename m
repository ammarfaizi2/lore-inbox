Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272634AbRHaI2G>; Fri, 31 Aug 2001 04:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272635AbRHaI15>; Fri, 31 Aug 2001 04:27:57 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:19613 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S272634AbRHaI1m>;
	Fri, 31 Aug 2001 04:27:42 -0400
Date: Fri, 31 Aug 2001 09:27:53 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Jonathan Lundell <jlundell@pobox.com>, ptb@it.uc3m.es, gordo@pincoya.com
Cc: linux kernel <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Message-ID: <821911999.999250073@[169.254.198.40]>
In-Reply-To: <p05100301b7b4f098f76c@[10.128.7.49]>
In-Reply-To: <p05100301b7b4f098f76c@[10.128.7.49]>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>># define __MIN(x,y) ({\
>>    typeof(x) _x = x; \
>>    typeof(y) _y = y; \
>>    _x < _y ? _x : _y ; \
>>  })
>
> How about typeof(__MIN(u, s)), given unsigned u, int s?

As this would expand to typeof({typeof(u) _u=u .... ? _u : _s;})
I am willing to bet it wouldn't even compile with either
version of min, so it doesn't matter.
--
Alex Bligh
