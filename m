Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbRFSVLk>; Tue, 19 Jun 2001 17:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264791AbRFSVLa>; Tue, 19 Jun 2001 17:11:30 -0400
Received: from AGrenoble-101-1-1-226.abo.wanadoo.fr ([193.251.23.226]:3737
	"EHLO lyon.ram.loc") by vger.kernel.org with ESMTP
	id <S264790AbRFSVLM>; Tue, 19 Jun 2001 17:11:12 -0400
To: linux-kernel@vger.kernel.org
From: Raphael_Manfredi@pobox.com (Raphael Manfredi)
Subject: Re: How to compile on one machine and install on another?
Date: 19 Jun 2001 21:11:06 GMT
Organization: Home, Grenoble, France
Message-ID: <9gof5a$52f$1@lyon.ram.loc>
In-Reply-To: <E15CSDK-0006ee-00@the-village.bc.nu> <Pine.LNX.4.33.0106191646330.17727-100000@localhost.localdomain>
X-Newsreader: trn 4.0-test74 (May 26, 2000)
In-Reply-To: <Pine.LNX.4.33.0106191646330.17727-100000@localhost.localdomain>
X-Mailer: newsgate 1.0 at lyon.ram.loc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tom Diehl <tdiehl@pil.net> from ml.linux.kernel:
:What is the best way to install the modules? Is there a directory _all_ of
:the modules exist in b4 you do "make modules_install". I usually end up
:setting EXTRAVERSION to something unique and doing a make modules_install.
:That way it does not hose up the modules for the build machine.
:Is there a better way?

Yes, there is.  I usually add the the following to the main Makefile:

export INSTALL_PATH=/nfs/lyon/home/ram/root-install/boot
export INSTALL_MOD_PATH=/nfs/lyon/home/ram/root-install

I then proceed as usual, and the modules get copied over NFS to
the target machine, in root-install/lib/modules, etc...

If you don't have NFS mounts to the remote machine, you'll have to
rcp the tree, that's all.

Raphael
