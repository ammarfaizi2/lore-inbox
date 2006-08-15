Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbWHOOvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWHOOvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 10:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWHOOvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 10:51:11 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:22173 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1030325AbWHOOvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 10:51:09 -0400
Date: Tue, 15 Aug 2006 16:47:56 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chris Wedgwood <cw@f00f.org>
cc: Nathan Scott <nathans@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer
 dereference at virtual address 00000078
In-Reply-To: <20060815143709.GA21591@tuatara.stupidest.org>
Message-ID: <Pine.LNX.4.61.0608151644460.9359@yvahk01.tjqt.qr>
References: <20060808185405.B2528231@wobbly.melbourne.sgi.com>
 <9a8748490608100431m244207b1v9c9c5087233fcf3a@mail.gmail.com>
 <20060811083546.B2596458@wobbly.melbourne.sgi.com>
 <9a8748490608101544n29f863e7o7584ac64f1d4c210@mail.gmail.com>
 <9a8748490608101552w12822fa6m415a5fb5537c744d@mail.gmail.com>
 <9a8748490608110133v5f973cf6w1af340f59bb229ec@mail.gmail.com>
 <9a8748490608110325k25c340e2yac925eb226d1fe4f@mail.gmail.com>
 <20060814120032.E2698880@wobbly.melbourne.sgi.com>
 <9a8748490608140049t492742cx7f826a9f40835d71@mail.gmail.com>
 <20060815190343.A2743401@wobbly.melbourne.sgi.com> <20060815143709.GA21591@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 1.0 points, 6.0 required
	1.0 SUBJ_HAS_UNIQ_ID       Subject contains a unique ID
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Its not clear to me where the rename operation happens in all of
>> this - does rsync create a local, temporary copy of the file and
>> then rename it?
>
>Yes, this is normally how rsync does it.

If file already exists {
    foreach block {
        copy block either from disk or from the 
        source operand, whichever is never, to temp file
    }
}

When rsync catches a signal {
    move the tempfile to the original name
}





Jan Engelhardt
-- 
