Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUKXUo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUKXUo3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 15:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbUKXUmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 15:42:46 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:43479 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262848AbUKXUmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 15:42:09 -0500
Date: Wed, 24 Nov 2004 14:41:38 -0600
From: Maneesh Soni <maneesh@in.ibm.com>
To: "Christopher S. Aker" <caker@theshore.net>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>, axboe@suse.de
Subject: Re: 2.6.10-rc2-bk7 - kernel BUG at fs/sysfs/file.c:87!
Message-ID: <20041124204138.GA2543@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <002c01c4d25b$3e8b9b10$0201a8c0@hawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002c01c4d25b$3e8b9b10$0201a8c0@hawk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 07:26:43PM +0000, Christopher S. Aker wrote:
> Doing "cat /sys/block/sda/queue/iosched/show_status" produces the following BUG:
> 
> ------------[ cut here ]------------
> kernel BUG at fs/sysfs/file.c:87!

I think you are using cfq io scheduler. show_status is from cfq_ioched. Looks 
like return value freom cfq_status_show() is going beyond one page. 
read/write buffer for sysfs text attribute files is limited to one page. 

Maneesh


-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 6781896
