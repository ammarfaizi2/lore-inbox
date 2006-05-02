Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWEBGzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWEBGzk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWEBGzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:55:40 -0400
Received: from ns.suse.de ([195.135.220.2]:27608 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932413AbWEBGzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:55:39 -0400
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: ebiederm@xmission.com, herbert@13thfloor.at, dev@sw.ru,
       linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@us.ibm.com, frankeh@us.ibm.com
Subject: Re: [PATCH 7/7] uts namespaces: Implement CLONE_NEWUTS flag
References: <20060501203906.XF1836@sergelap.austin.ibm.com>
	<20060501203907.XF1836@sergelap.austin.ibm.com>
From: Andi Kleen <ak@suse.de>
Date: 02 May 2006 08:55:29 +0200
In-Reply-To: <20060501203907.XF1836@sergelap.austin.ibm.com>
Message-ID: <p7364ko7w66.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Implement a CLONE_NEWUTS flag, and use it at clone and sys_unshare.

I still think it's a design mistake to add zillions of pointers to task_struct
for every possible kernel object. Going through a proxy datastructure to 
merge common cases would be much better.

-Andi
