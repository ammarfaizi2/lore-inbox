Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287599AbRLaTBh>; Mon, 31 Dec 2001 14:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287606AbRLaTB2>; Mon, 31 Dec 2001 14:01:28 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:8970 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287599AbRLaTBZ>;
	Mon, 31 Dec 2001 14:01:25 -0500
Date: Mon, 31 Dec 2001 17:01:25 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] [WIP] Unbork fs.h, 3 of 3
Message-ID: <20011231170125.B15954@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	<linux-kernel@vger.kernel.org>, Alexander Viro <viro@math.psu.edu>,
	<linux-fsdevel@vger.kernel.org>
In-Reply-To: <E16Kv7J-0003CW-00@starship.berlin> <Pine.LNX.4.33.0112311004580.1404-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112311004580.1404-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 31, 2001 at 10:16:14AM -0800, Linus Torvalds escreveu:
> How about using a descriptor structure instead of the macro, and making
> the filesystem declaration syntax look more like
> 
> 	static struct file_system_type ext2_descriptor = {
> 		owner:		THIS_MODULE,
> 		fs_flags:	FS_REQUIRES_DEV,
> 		name:		"ext2",
> 		read_super:	ext2_read_super,
> 		sb_size:	sizeof(ext2_sb_info),
> 		inode_size:	sizeof(struct ext2_inode_info)
> 	};
> 
> which is more readable, and inherently documents _what_ those things are.

Agreed, this is how the other structs of similar purpose (proto_opts,
net_proto_family, etc) are initialized.

- Arnaldo
