Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285402AbRL0Bxv>; Wed, 26 Dec 2001 20:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285634AbRL0Bxm>; Wed, 26 Dec 2001 20:53:42 -0500
Received: from pop.gmx.de ([213.165.64.20]:65524 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S285099AbRL0Bxa>;
	Wed, 26 Dec 2001 20:53:30 -0500
Message-ID: <3C2A7EEA.44EAE386@gmx.de>
Date: Thu, 27 Dec 2001 02:52:42 +0100
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Pavel Roskin <proski@gnu.org>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: readdir() loses entries on ramfs and tmpfs
In-Reply-To: <Pine.LNX.4.43.0112261932350.26802-100000@marabou.research.att.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Roskin wrote:
> 
>     while ((d = readdir(dir)) != NULL) {
>         printf("%s\n", d->d_name);
>         rmdir(d->d_name);
>     }
>[...]
> Basically, removing a subdirectory in a directory open with opendir()
> causes an entry (file or directory) 168 entries later to be skipped by
> readdir().
> 
> I'm sorry, I cannot elaborate more, but the issue seems to be very
> serious.

Not nice but not serious.  Modifying the directory you scan is
never save and programs relying on this are broken.  You can
build a list of items to work on but even then another process
may add new entries or remove some and you have to handle that.
One could "fix" your "bug" but the program will still be broken.

Ciao, ET.
