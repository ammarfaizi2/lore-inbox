Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261511AbSKBXIH>; Sat, 2 Nov 2002 18:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261512AbSKBXIH>; Sat, 2 Nov 2002 18:08:07 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:6845 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S261511AbSKBXIG>;
	Sat, 2 Nov 2002 18:08:06 -0500
Date: Sun, 3 Nov 2002 00:14:35 +0100
From: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] Kernel GUI config
Message-ID: <20021102231435.GA2384@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I have readl all the comments about qconfig, gconfig, etc..., and I wanto to
comment about an idea that perhaps can make everybody happy...

I don't like qt. As many others. Others do not like GTK. QT requires a C++
compiler to configure the kernel. Everybody agrees on putting the gui config
tool outside the tree. So...

- Make a new target called 'guiconfig'. This is neutral, and just should call
  an utility called for example kconfig-gui.
- People can implement many different front ends and call them things like
  kconfig-qt, kconfig-gtk, kconfig-xaw, etc... The user can configure its
  own prefs with an alias or with 'alternatives' as some distros do. None
  of this utilities should be included in the tree. Put another dir in
  ftp.kernel.org.

To reduce implementation efforts (and bug chasing), as someone said, you
can take all the current parts toolkit-independent (parsers, etc.) from
qconf and split them in a library.

Other possibility is to let parsers in the kernel and generate some kind
of XML file the utilities should read (do not know how hard would be to put
dependencies on an XML file...).

This way even 'menuconfig' could be split as a separate package.

But please, don't force people to use one toolkit.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-rc1-jam0 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
