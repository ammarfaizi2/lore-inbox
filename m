Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbSLOPlA>; Sun, 15 Dec 2002 10:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261872AbSLOPk7>; Sun, 15 Dec 2002 10:40:59 -0500
Received: from 213-97-199-90.uc.nombres.ttd.es ([213.97.199.90]:387 "HELO
	fargo") by vger.kernel.org with SMTP id <S261855AbSLOPk6>;
	Sun, 15 Dec 2002 10:40:58 -0500
Date: Sun, 15 Dec 2002 16:49:44 +0100
From: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
To: David =?iso-8859-15?Q?San=E1n?= Baena <davidsanan@teleline.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems creating a driver
Message-ID: <20021215154944.GA1288@fargo>
Mail-Followup-To: David =?iso-8859-15?Q?San=E1n?= Baena <davidsanan@teleline.es>,
	linux-kernel@vger.kernel.org
References: <002901c2a43a$b057d5c0$6e9afea9@anabel>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <002901c2a43a$b057d5c0$6e9afea9@anabel>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David ;);

> totcl.cc:60: sorry, not implemented: non-trivial labeled initializers
> totcl.cc:60: cannot convert `int (*) (inode *, file *)' to `ssize_t (*)
> (file *, char *, unsigned int, loff_t *)' in initialization
> make: *** [totcl.ko] Error 1

I think the problem it's that designated initializers are not implemented in 
the GNU c++ compiler, so you have to initialize all the field in the structure.

> my file_operations var is:
> struct file_operations totcl_fops=
> {
>  read:totcl_read,
>  open:totcl_open,
>  release:totcl_release,
> };

By the way, C99 syntax is better, most of the kernel has been changed to the
new syntax:

struct file_operations totcl_fops=
{
    .read=totcl_read,
    .open=totcl_open,
    .release=toctl_release,
};


--
David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra
