Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289891AbSAPJOi>; Wed, 16 Jan 2002 04:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290385AbSAPJOY>; Wed, 16 Jan 2002 04:14:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18445 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289891AbSAPJMW>;
	Wed, 16 Jan 2002 04:12:22 -0500
Message-ID: <3C4543F0.29CCD025@mandrakesoft.com>
Date: Wed, 16 Jan 2002 04:12:16 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: Re: likely/unlikely
In-Reply-To: <3C450C4A.8A8382A6@mandrakesoft.com> <20020116060014.GB24266@krispykreme>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
> 
> 
> > likely/unlikely set the branch prediction values to 99% or 1%
> > respectively.  If this causes the code generated to perform less
> > optimally than without, I'm sure the gcc guys would be -very- interested
> > to hear that...
> 
> On some ppc64 the branch prediction is quite good and static prediction
> will override the dynamic prediction. I think we avoid predicting a
> branch unless we are quite sure (95%/5%).
> 
> So if likely/unlikely is overused (on more marginal conditionals) then
> it could be a performance loss.

oh agreed... but marginal conditionals should not be getting
likely()/unlikely() as you are then lying to the compiler about the true
branch predictability...

	Jeff


-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
