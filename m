Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbTLQBDJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 20:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbTLQBDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 20:03:09 -0500
Received: from holomorphy.com ([199.26.172.102]:48268 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262767AbTLQBDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 20:03:07 -0500
Date: Tue, 16 Dec 2003 17:02:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Steve French <smfltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-cifs-client@lists.samba.org,
       darren@dmdtech.org
Subject: Re: cifs causes high system load avg, oopses when unloaded on 2.6.0-test11
Message-ID: <20031217010248.GA31393@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Steve French <smfltc@us.ibm.com>, linux-kernel@vger.kernel.org,
	linux-cifs-client@lists.samba.org, darren@dmdtech.org
References: <1071609977.1806.27.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071609977.1806.27.camel@stevef95.austin.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Hmm, this unload needs to hand back failure to module unload when it>>
>> can't nuke inodes etc. I'd suggest not using it as a module for the
>> time being.

On Tue, Dec 16, 2003 at 03:26:17PM -0600, Steve French wrote:
> I don't see how I could pass failure back on module unload even if I
> could detect problems freeing the memory associated with cifs's inode
> cache - there is no place for return code info - see the caller ie the
> call to mod->exit() in sys_delete_module (about line 735 of
> kernel/module.c)

Right, the facility isn't there. Maybe making the thing not-unloadable
would be the best option for the time being.


-- wli
