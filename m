Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760272AbWLFG4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760272AbWLFG4H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 01:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760275AbWLFG4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 01:56:06 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:40629 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760272AbWLFG4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 01:56:03 -0500
Date: Tue, 5 Dec 2006 22:55:39 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, val_henson@linux.intel.com,
       viro@zeniv.linux.org.uk
Subject: Re: + ocfs2-relative-atime-support-tweaks.patch added to -mm tree
Message-ID: <20061206065539.GF4497@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <200612060612.kB66CjNW025289@shell0.pdx.osdl.net> <20061206062809.GD4497@ca-server1.us.oracle.com> <20061205224311.5dcfaf20.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205224311.5dcfaf20.akpm@osdl.org>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 10:43:11PM -0800, Andrew Morton wrote:
> The logic I have there is the same (I hope)...
> 
> +			if (timespec_compare(&inode->i_mtime,
> +						&inode->i_atime) < 0 &&
> +			    timespec_compare(&inode->i_ctime,
> +						&inode->i_atime) < 0)
> +				return;
Oh ok, yeah I didn't notice that the arguments to timespec_compare() had
been changed!
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
