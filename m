Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286501AbSAFAQJ>; Sat, 5 Jan 2002 19:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286495AbSAFAP7>; Sat, 5 Jan 2002 19:15:59 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:12111 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S286521AbSAFAPt>;
	Sat, 5 Jan 2002 19:15:49 -0500
Message-ID: <20020106011550.A7723@win.tue.nl>
Date: Sun, 6 Jan 2002 01:15:50 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: 0@pervalidus.net, linux-kernel@vger.kernel.org
Subject: Re: losetuping files in tmpfs fails?
In-Reply-To: <20020105215147.GH136@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: =?iso-8859-1?Q?=3C20020105215147=2EGH136=40pervalidus=3E=3B_from_Fr=E9d?=
 =?iso-8859-1?Q?=E9ric_L=2E_W=2E_Meunier_on_Sat=2C_Jan_05=2C_2002_at_07:5?=
 =?iso-8859-1?Q?1:47PM_-0200?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2002 at 07:51:47PM -0200, F.W. Meunier wrote:

> On a side note, why do I need to use losetup -d after umount
> when /etc/mtab is a symlink to /proc/mounts ?
> 
> mount or loop "feature" ?

mount will do losetup -d at umount time if and only if it did losetup
at mount time, as is recorded in /etc/mtab. With a symlink that info
is lost. See mount(8).

