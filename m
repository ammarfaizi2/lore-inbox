Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262849AbTDAUQt>; Tue, 1 Apr 2003 15:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262845AbTDAUQs>; Tue, 1 Apr 2003 15:16:48 -0500
Received: from to-telus.redhat.com ([207.219.125.105]:32506 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S262840AbTDAUPt>; Tue, 1 Apr 2003 15:15:49 -0500
Date: Tue, 1 Apr 2003 15:27:13 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: akpm@digeo.com, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Filesystem aio rdwr patchset
Message-ID: <20030401152713.B26513@redhat.com>
References: <20030401215957.A1800@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030401215957.A1800@in.ibm.com>; from suparna@in.ibm.com on Tue, Apr 01, 2003 at 09:59:57PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 09:59:57PM +0530, Suparna Bhattacharya wrote:
> I would really appreciate comments and review feedback 
> from the perspective of fs developers especially on
> the latter 2 patches in terms of whether this seems a 
> sound approach or if I'm missing something very crucial
> (which I just well might be)
> Is this easy to do for other filesystems as well ?

I disagree with putting the iocb pointer in the task_struct: it feels 
completely bogus as it modifies semantics behind the scenes without 
fixing APIs.

		-ben
-- 
Junk email?  <a href="mailto:aart@kvack.org">aart@kvack.org</a>
