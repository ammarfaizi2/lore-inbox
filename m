Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbVIUVDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbVIUVDp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 17:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbVIUVDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 17:03:45 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:40403
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S964844AbVIUVDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 17:03:44 -0400
Date: Wed, 21 Sep 2005 16:58:52 -0400
From: Sonny Rao <sonny@burdell.org>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
       dipankar@in.ibm.com, bharata@in.ibm.com
Subject: Re: dentry_cache using up all my zone normal memory -- also seen on 2.6.14-rc2
Message-ID: <20050921205852.GA28292@kevlar.burdell.org>
References: <433189B5.3030308@nortel.com> <43318FFA.4010706@nortel.com> <4331B89B.3080107@nortel.com> <20050921200758.GA25362@kevlar.burdell.org> <4331C9B2.5070801@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4331C9B2.5070801@nortel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 02:59:30PM -0600, Christopher Friesen wrote:
> Sonny Rao wrote:
> 
> >Over one million files open at once is just asking for trouble on a
> >lowmem-crippled x86 machine, IMHO.
> 
> I don't think there actually are.  I ran the testcase under strace, and 
> it appears that there are two threads going at once.
> 
> thread 1 spins doing the following:
> fd = creat("./rename14", 0666);
> unlink("./rename14");
> close(fd);
> 
> thread 2 spins doing:
> rename("./rename14", "./rename14xyz");

Try running lsof and grepping for the process name 

