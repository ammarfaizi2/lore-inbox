Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275610AbRJAVzO>; Mon, 1 Oct 2001 17:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275611AbRJAVzE>; Mon, 1 Oct 2001 17:55:04 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:21924 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S275610AbRJAVzB>;
	Mon, 1 Oct 2001 17:55:01 -0400
Date: Mon, 01 Oct 2001 22:55:26 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Andreas Dilger <adilger@turbolabs.com>,
        Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Cc: linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: /dev/random entropy calculations broken?
Message-ID: <45266246.1001976925@[195.224.237.69]>
In-Reply-To: <20011001105927.A22795@turbolinux.com>
In-Reply-To: <20011001105927.A22795@turbolinux.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, 01 October, 2001 10:59 AM -0600 Andreas Dilger 
<adilger@turbolabs.com> wrote:

> Has anyone even checked whether the current entropy estimates even work
> properly?

And while we're at it, many things which add to entropy are
observable by non-root users (interupt timings always, mouse
movements, keypresses if a non-root user is logged in at
the console). And entropy is overestimate on some non-x86
platforms due to lack of fine-grained timer implementations.
And without Robert Love's patch the choice of whether to source
it from network events is completely arbitrary (NIC dependent)

However, unless one is worried about someone having broken
SHA-1 OR one is worried about annoying blocking behavour
on read(), I'm not convinced the entropy calculation is
doing anything useful anyway.

People do, however, seem particularly reluctant to accept
any change in this area.

--
Alex Bligh
