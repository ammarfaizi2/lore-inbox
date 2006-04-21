Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWDUXEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWDUXEA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 19:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWDUXEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 19:04:00 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:52297 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750715AbWDUXEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 19:04:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=iYCqmeTA4TS5ha//NpgzIpyQBRWgY4UI647zjXCMLgAUXAl2Ch6IXNQBOqOBzXZUQ279hGfDYxzvyEHaIu6JdMpnejRnthrPR/pHoeib++/Xi1KMAx1PxUEOE4gVGh+0sd3jaCIvxpj25mShnYYQ4drsLbT+fFn6Xp1b7aMstO8=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Daniel Walker'" <dwalker@mvista.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <jmorris@namei.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: kfree(NULL)
Date: Fri, 21 Apr 2006 16:03:57 -0700
Message-ID: <000f01c66597$df66ef50$853d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <1145660319.20843.41.camel@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcZllyKB81wfKr4IRu+9vXiPytMyXAAAJn6w
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It seems including atomic.h inside compiler.h is a bit 
> tricky (might have interdependency).
> > 
> > Can we just live with int instead of atomic_t? We don't 
> really care about losing a count occasionally..
> 
> It's nice so you don't have to fool around with locking .. 
> The atomic_t structure is pretty simple thought . I think it 
> boils down to just an int anyway .

We could move atomic_t into a separate atomic_type.h? I just want to make sure before I mess with the file structure..

Hua

