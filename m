Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030407AbWGNIsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbWGNIsM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 04:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWGNIsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 04:48:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:35923 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932445AbWGNIsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 04:48:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g7ckWMgJlzVxRYOAaj+jWAoG17zQZ0d+n6wtAiHzBDhXxBMHogHtZACJ/9OkYyJqNbC54j/mDXojmg8wYJif9g32PMQKSJA1o4eG4EfBQrQAGv4iSUVBKSDQq7Iq00XCtnhMJPdH8VdIecJ5nIAWbpUdHbiQs3o0mjtJa8kMOmk=
Message-ID: <9a8748490607140148x70663e27k2f03367165ab4c0b@mail.gmail.com>
Date: Fri, 14 Jul 2006 10:48:10 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "wyb@topsec.com.cn" <wyb@topsec.com.cn>
Subject: Re: SMP share data declaration
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <002001c6a6f1$74ff85f0$0100000a@codingman>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <002001c6a6f1$74ff85f0$0100000a@codingman>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/06, wyb@topsec.com.cn <wyb@topsec.com.cn> wrote:
> I know that an integer variable should be declared volatile to share between
> CPUs.

NO. volatile won't protect you sufficiently.

Use spinlocks, mutexes, semaphores, barriers and the like to protect
variables from concurrent access. Using volatile for this is a BUG and
it won't work correctly.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
