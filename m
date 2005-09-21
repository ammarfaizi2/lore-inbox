Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbVIUVOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVIUVOt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 17:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbVIUVOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 17:14:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58821 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964808AbVIUVOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 17:14:49 -0400
Date: Wed, 21 Sep 2005 22:14:38 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Christopher Friesen <cfriesen@nortel.com>, Sonny Rao <sonny@burdell.org>,
       linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
       bharata@in.ibm.com
Subject: Re: dentry_cache using up all my zone normal memory -- also seen on 2.6.14-rc2
Message-ID: <20050921211438.GC7992@ftp.linux.org.uk>
References: <433189B5.3030308@nortel.com> <43318FFA.4010706@nortel.com> <4331B89B.3080107@nortel.com> <20050921200758.GA25362@kevlar.burdell.org> <4331C9B2.5070801@nortel.com> <20050921210019.GF4569@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050921210019.GF4569@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 02:30:20AM +0530, Dipankar Sarma wrote:
> > unlink("./rename14");
> > close(fd);
> > 
> > thread 2 spins doing:
> > rename("./rename14", "./rename14xyz");
> 
> Ewww.. Looks like a leak due to a race.

Looks like sillyrename being b0rken, if that's NFS...
