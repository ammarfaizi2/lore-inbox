Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266679AbUGVPSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266679AbUGVPSh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 11:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266630AbUGVPSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 11:18:36 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:19921 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266124AbUGVPRe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 11:17:34 -0400
Subject: Re: Inode question
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: sankarshana rao <san_wipro@yahoo.com>
Cc: root@chaos.analogic.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040721225752.90581.qmail@web50902.mail.yahoo.com>
References: <20040721225752.90581.qmail@web50902.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1090499783.17490.42.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Jul 2004 07:36:23 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-21 at 17:57, sankarshana rao wrote:
> Guys,
> Thx for the inputs...I got it with path_lookup....
> 
> Can I pass the inode pointer back to the user space???

You shouldn't do that.

> I have a scenario in which I have to create multiple
> folders on the harddisk. The number of folders can be
> in hundreds. Instead of parsing the path name
> everytime I need to create a folder (that's what
> sys_mkdir does??? ), I was thinking if I have the
> inode* of the parent folder, I can avoid this parsing
> and directly create a subfolder under the parent
> folder...

Couldn't the program chdir to the parent directory and create the
folders with a relative pathname?
-- 
David Kleikamp
IBM Linux Technology Center

