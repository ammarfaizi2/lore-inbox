Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263711AbREYLWj>; Fri, 25 May 2001 07:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263710AbREYLW3>; Fri, 25 May 2001 07:22:29 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:1544 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S263711AbREYLWQ>; Fri, 25 May 2001 07:22:16 -0400
Date: Fri, 25 May 2001 13:20:50 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: "SATHISH.J" <sathish.j@tatainfotech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reg ramfs mkfs
Message-ID: <20010525132050.J12364@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.10.10105251239050.11760-100000@blrmail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10105251239050.11760-100000@blrmail>; from sathish.j@tatainfotech.com on Fri, May 25, 2001 at 12:44:30PM +0530
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 12:44:30PM +0530, SATHISH.J wrote:
> I compiled the ramfilesystem under fs/ramfs and got the object file
> inode.o.
> 
> 1.Should I do insmod to insert this module. 

No, you should insmod ramfs.o.

> 2.After inserting this module how can I use "mkfs" to make this file
> system befor mounting it.

Ramfs is a virtual filesystem, it doesn't use a block device, it lives
in the page cache. Just mount it to use it:

  mount -t ramfs none /mnt


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
