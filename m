Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262652AbTCTXiz>; Thu, 20 Mar 2003 18:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbTCTXiz>; Thu, 20 Mar 2003 18:38:55 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:50621 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S262652AbTCTXiy>; Thu, 20 Mar 2003 18:38:54 -0500
Date: Thu, 20 Mar 2003 15:49:46 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Larger dev_t and major/minor split
Message-ID: <20030320234946.GT2835@ca-server1.us.oracle.com>
References: <b5dckh$lv1$1@cesium.transmeta.com> <20030320220901.GR2835@ca-server1.us.oracle.com> <3E7A4977.5090700@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7A4977.5090700@zytor.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 03:06:31PM -0800, H. Peter Anvin wrote:
> Last I checked, all traditional (inode-based) Unix filesystems,
> including ext2/3 used block pointers for dev_t.  There are plenty of
> block pointers; 60 bytes worth.

	They do indeed.  But ext2/3 touches that block pointer with
cpu_to_le32() and friends.  It needs fixing at best, and compatability
work for already existing partitions.

Joel

-- 

"There is shadow under this red rock.
 (Come in under the shadow of this red rock)
 And I will show you something different from either
 Your shadow at morning striding behind you
 Or your shadow at evening rising to meet you.
 I will show you fear in a handful of dust."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
