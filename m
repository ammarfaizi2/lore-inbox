Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265675AbTBXJDv>; Mon, 24 Feb 2003 04:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265687AbTBXJDv>; Mon, 24 Feb 2003 04:03:51 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:58783 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S265675AbTBXJDs>; Mon, 24 Feb 2003 04:03:48 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: "Downing, Thomas" <Thomas.Downing@ipc.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.5.62 "unable to open initial console"
Date: Mon, 24 Feb 2003 10:13:48 +0100
User-Agent: KMail/1.5
References: <170EBA504C3AD511A3FE00508BB89A9201C671F7@exnanycmbx4.ipc.com>
In-Reply-To: <170EBA504C3AD511A3FE00508BB89A9201C671F7@exnanycmbx4.ipc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302241013.49014.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please check out this thread: "2.5.62 fails to boot, Uncompressing... and then nothing"

You need to enable the console in your .config:

CONFIG_VT=y
CONFIG_VT_CONSOLE=y

See the above thread for more details.

I hope this helps,

Duncan.

On Sunday 23 February 2003 22:11, Downing, Thomas wrote:
> Apologies of off-topic or screamingly idiotic or newbie :-)
>
> Booting 2.5.62 results in no console.  Looking at syslog shows:
>
> Warning: unable to open initial console
>
> I am not using devfs - /dev/console is there, char major 5, minor 1.
>
> Kernel was built without MDA or framebuffer support, without serial or
> parallel console, with CONFIG_VGA_CONSOLE 1 and CONFIG_DUMMY_CONSOLE 1.
>
> Problem has been present since at least 2.5.59.
>
> System runs normally if booted with 2.5.24.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
