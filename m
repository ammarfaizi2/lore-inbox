Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262689AbTCJCNO>; Sun, 9 Mar 2003 21:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262690AbTCJCNO>; Sun, 9 Mar 2003 21:13:14 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:7081 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262689AbTCJCNN>;
	Sun, 9 Mar 2003 21:13:13 -0500
Date: Sun, 9 Mar 2003 21:23:41 -0500
From: Alexander Viro <viro@math.psu.edu>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: struct inode size reduction.
Message-ID: <20030309212341.A29753@math.psu.edu>
References: <20030309135402.GB32107@suse.de> <20030309171314.GA3783@win.tue.nl> <20030309203359.GA7276@suse.de> <20030309195555.A22226@infradead.org> <20030309203144.GA3814@win.tue.nl> <Pine.LNX.4.44.0303092310470.32518-100000@serv> <20030309230824.GA3842@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030309230824.GA3842@win.tue.nl>; from aebr@win.tue.nl on Mon, Mar 10, 2003 at 12:08:24AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 12:08:24AM +0100, Andries Brouwer wrote:
> =====
> +int register_chrdev(unsigned int major, const char *name,
> +                   struct file_operations *fops)
> +{
> +       return register_chrdev_region(major, 0, 256, name, fops);
> +}

That's Wrong API(tm).  Why do you need to keep separation between
major and first minor?  Just pass dev_t start and unsigned len.

BTW, I'd like to take a look at your CIDR for chrdev - I've got one
to resurrect and it might make sense to compare-and-merge.  And
yes, I'm finally back - hopefully for good.
