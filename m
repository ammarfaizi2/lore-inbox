Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312544AbSCYUQt>; Mon, 25 Mar 2002 15:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312543AbSCYUQo>; Mon, 25 Mar 2002 15:16:44 -0500
Received: from kirsti.kvarteret.uib.no ([129.177.162.235]:10637 "EHLO
	ttt.kvarteret.org") by vger.kernel.org with ESMTP
	id <S312544AbSCYUQM>; Mon, 25 Mar 2002 15:16:12 -0500
Date: Mon, 25 Mar 2002 21:15:41 +0100
From: =?iso-8859-1?Q?Kjetil_Nyg=E5rd?= <kjetiln@kvarteret.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with booting from SX6000
Message-ID: <20020325211541.A30644@kvarteret.org>
In-Reply-To: <20020325024022.A6502@kvarteret.org> <E16pTp5-0000RP-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Scanner: exiscan *16pasX-00085p-00*LShGxlMPeTg* (Det Akademiske Kvarter, Bergen, Norway)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 12:43:39PM +0000, Alan Cox wrote:
> > Partition Check: 
> > i2o/hda: i2o/hda1 i2o/hda2 i2o/hda3 i2o/hda4 < i2o/hda5 i2o/hd6 >
> > Loading jbd module
> 
> It found your SX6000
> 
> > Creating root device
> > Mounting root filesystem
> > Mounting: error 19 ext3
> 
> And mount failed (No such device).
> 
> That sounds like your root= line is wrong in the lilo setup. I'd assumed it
> was getting further then hanging

I had the correct option for mounting (in grub):
	kernel <some kernel> ro root=/dev/i2o/hda6

To work around the problem I reinstalled the system, where I put the / on a seperate disk, and /var, /usr, /tmp etc.. om the /dev/i2o/hda...

So there seems like there is a problem with the mount-program in the kernel. 




