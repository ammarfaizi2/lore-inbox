Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290405AbSAPKfv>; Wed, 16 Jan 2002 05:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290397AbSAPKfl>; Wed, 16 Jan 2002 05:35:41 -0500
Received: from mail.merconic.com ([62.96.220.180]:61396 "HELO
	mail.merconic.com") by vger.kernel.org with SMTP id <S290393AbSAPKf0>;
	Wed, 16 Jan 2002 05:35:26 -0500
Date: Wed, 16 Jan 2002 11:35:17 +0100
From: "marc. h." <heckmann@hbe.ca>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [problem captured] Re: cerberus on 2.4.17-rc2 UP
Message-ID: <20020116113516.D4627@hbe.ca>
In-Reply-To: <20020108164816.A5453@hbe.ca> <E16Nysp-0006tn-00@the-village.bc.nu> <3C3B579D.7B8E534F@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C3B579D.7B8E534F@zip.com.au>; from akpm@zip.com.au on Tue, Jan 08, 2002 at 12:33:33PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok, the ext3-2.4-0.9.17 patch fixes this bug. thank you. that means that
2.4.17-rc2 with the patch applied makes it through a full *double* cerberus run
succesfully. I also tried the same with ext2 and it made it through as well. I
plan to try and 18-preX as well soon. If only such a test wasn't a day and a
half long...

The only other thing that seems to effecting a lot of people (including a
friend of mine) that I can't re-produce here, is the OOPses... A box that was
stable with 2.4.12 oops'es in short time with 2.4.1[67]. The box in question is
a Dell desktop running a netfilter firewall.

-m

On Tue, Jan 08, 2002 at 12:33:33PM -0800, Andrew Morton wrote:
> Alan Cox wrote:
> > 
> > Other people have reported it too. Its clearly a kernel race
> 
> Yes, I can generate it at will on two quite different IDE machines
> with the run-bash-shared-mapping script from
> http://www.zip.com.au/~akpm/ext3-tools.tar.gz
> 
> It's on my list of things-to-do, filed under "hard".  It even happens
> on uniprocessor, with unmask_irq=0.
> 
> Interestingly, I _think_ it only ever occurs against the
> swap device.  But I need to confirm this.  Marc, do you
> have swap on /dev/hda1?
> 

-- 
	C3C5 9226 3C03 CDF7 2EF1  029F 4CAD FBA4 F5ED 68EB
	key: http://people.hbesoftware.com/~heckmann/
