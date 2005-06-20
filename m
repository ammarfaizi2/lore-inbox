Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVFTBzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVFTBzh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 21:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVFTBzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 21:55:37 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:22426 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261167AbVFTBz3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 21:55:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iGrA6AjdTDK64ETBMIeQrerAXd7I4JZxfkpPrkO2jRVdqeQV98BgH8Tpv0/Q4FmRo6VX3g+XmBDjES94bHUAnXbiv+ESbEQzGwB73Ln4XalNAPq+wKTs3U8IlX0d40mwmi7U6o6WPxc2n64mO312nsM7e5C66U7KyGvgTduGMts=
Message-ID: <d73ab4d0050619185556d25234@mail.gmail.com>
Date: Mon, 20 Jun 2005 09:55:29 +0800
From: guorke <gourke@gmail.com>
Reply-To: guorke <gourke@gmail.com>
To: linux-os@analogic.com
Subject: Re: mabye simple,but i confused
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0506160819350.29979@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d73ab4d005061522254f2e5933@mail.gmail.com>
	 <Pine.LNX.4.61.0506160819350.29979@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,I must read it carefully

On 6/16/05, Richard B. Johnson <linux-os@analogic.com> wrote:
> On Thu, 16 Jun 2005, guorke wrote:
> 
> > in understangding the linux kernel, the authors says
> > "..Moves itself from address 0x00007c00 to address 0x00090000.."
> >
> > What i confused is why the Boot Loader do this, i asked google,but
> > still no answe.
> > who can make me understand it ?
> > Thanks.
> 
> The IBM 'IPL' (initial program load) address was specified to be
> at 7c00. There was room here for only one "sector", which in the
> early days was 512 bytes. The very first sector, the boot sector,
> was loaded into this address and then execution was started at
> a specified offset so that this boot code could load the rest
> of the operating system. To load the rest of the operating system,
> one needs to move the boot-code to somewhere it won't get
> overwritten by subsequent reads from the disk.
> 
> To load Linux, the boot developers wanted to load code 64k at
> a time. The only address in real-mode, that was guaranteed to
> not be in use, where the boot code could load a whole 64k was
> at 90000 hex. This provides a buffer from which the boot-loader
> can copy 64k at a time into the protected-mode address space
> starting at 0x00100000. The boot-loader uses real-mode BIOS
> services to copy the code to the 1 megabyte address which can't
> be reached in real mode.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
>  Notice : All mail here is now cached for review by Dictator Bush.
>                  98.36% of all statistics are fiction.
>
