Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290156AbSAQTGD>; Thu, 17 Jan 2002 14:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290164AbSAQTFy>; Thu, 17 Jan 2002 14:05:54 -0500
Received: from smtp.cogeco.net ([216.221.81.25]:37887 "EHLO fep9.cogeco.net")
	by vger.kernel.org with ESMTP id <S290156AbSAQTFj> convert rfc822-to-8bit;
	Thu, 17 Jan 2002 14:05:39 -0500
Subject: Re: hangs using opengl
From: "Nix N. Nix" <nix@go-nix.ca>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1011292729.12873.27.camel@tux>
In-Reply-To: <3C4712DB.6090201@kabelfoon.nl>  <1011292729.12873.27.camel@tux>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.1 
Date: 17 Jan 2002 14:03:10 -0500
Message-Id: <1011294257.13517.1.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-17 at 13:37, Nix N. Nix wrote:
> On Thu, 2002-01-17 at 13:07, Nick Martens wrote:
> > Hi,
> > I'm having some trouble with my box, at the time that i start an opengl 
> > game in X sometimes the load of my machine gets really high (not in all 
> > games Quake III runs just fine). when i try to move my mouse it won't 
> > move, when i press CTRL-ALT-BACKSPACE nothing happens and I have to 
> > reset my system. Is this kernel related or just an opengl problen ? if 
> > it's kernel related I am running kernel 2.4.5 And my video-card is an 
> > NVIDIA geforce 2 pro 450 from gainward. before this card i had a diamond 
> > viper 770 ultra and the same problem occured. If this is not a kernel 
> > issue: where can i go to solve this ????
> 
> First off, please forgive any non-compliance with linux-kernel posting
> protocol in the posting about to follow. 
> 
> Via has recently released a patch to Via-chipset based boards that
> addresses issues Windows XP users have been experiencing (BSODs and
> friends) while playing OpenGL games, especially with NVidia chips.  The
> problem and the description of the fix (as taken from the Readme.txt
> from Via's patch) are as follow: 
> 
> "
> So what does it do? It closes the RX55 memory register in BIOS. The RX55
> register's official name and function is Memory Write Queue (MWQ) timer.
> The MWQ timer is actually a timing device included in the memory host
> controller to prevent write data being held in the memory queue too
> long. After the data has been in the queue too long it times out. This
> timed out data is then given a higher write request priority. Now that
> might sound nice a bit of extra performance BUT the procedure fails when
> overloaded. 3D games and Win XP put too much load on the memory queuing
> timer procedure. The nVidia new driver exaggerates the problem even more
> as the driver enables nVidia cards to use even more memory than previous
> driver versions.
> 
> So in a nutshell it’s a memory timing problem that only happens when the
> RX55 register is opened. Some motherboard manufacturers have already
> released new BIOS that have the register closed. In other instances,
> this patch is needed. 
> "
> 
> I have an AMD Athlon 1200 CPU on an Asus board running the VIA KT266A
> North Bridge System Chipset and the VIA VT8233 South Bridge System
> Chipset.  My video card is an NVidia GeForce2MX with the drivers from
> NVidia in place and working (OpenGL /is/ accelerated).
> 
> I have experienced the same problem as Nick in that, whenever I run an
> OpenGL screensaver or Unreal Tournament, the computer will freeze at
> some unpredictable time (usually when I'm leading the game ;o) ).  If I
> ssh in and kill the X server, it freezes completely and has to be
> rebooted via Reset button.
> 
> In light of VIAs discoveries, and the fact that the patch that they now
> have available for Windows is not available for Linux also, I was
> wondering if somebody on this list may be kind enough to help us with
> what may very well be the symptoms of the same problem, but on Linux. 
> Could the code that accomplishes the above (turn off the RX55 register)
> be made into a patch that can be applied to the kernel, thus providing
> an equivalent patch for Linux systems ?
> 
> Please keep in mind that VIA provides this patch strictly as a beta, and
> will most likely include it in their next release of the 4in1 drivers
> (which are available for Windows only - no Linux support "at this
> time").   They say that, after more testing, if this proves to be a fix,
> they will include it.
> 
> For further info, please consult the followings:
> http://www.viaarena.com/?PageID=64
> http://www.theddrzone.com/news.asp?id=404
> 
> 
> 
> Thanks.
> > 
> > Greets Nick


