Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbVHQXdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbVHQXdP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 19:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVHQXdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 19:33:15 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:24311 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751330AbVHQXdO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 19:33:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZeXd/U/Wy3wNlfqATlcdNlKwIq7YJUuAi1R/JWKZwv7YUlfQTuE7vKJFMlWGROcVcqGqDDTvKQE0MskS+zXAeEHKNXARco/7Q+HfBBFFOGWxh0J/5GQOZ4FX0vkpSz9kckmizdbLCC18p5Ybq01VF4umoiaAPbrhax2w35Hfj6I=
Message-ID: <a762e240508171633ea4d903@mail.gmail.com>
Date: Wed, 17 Aug 2005 16:33:13 -0700
From: Keith Mannthey <kmannth@gmail.com>
To: "Davda, Bhavesh P (Bhavesh)" <bhavesh@avaya.com>
Subject: Re: Debugging kernel semaphore contention and priority inversion
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <21FFE0795C0F654FAD783094A9AE1DFC0830FC77@cof110avexu4.global.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <21FFE0795C0F654FAD783094A9AE1DFC0830FC77@cof110avexu4.global.avaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/05, Davda, Bhavesh P (Bhavesh) <bhavesh@avaya.com> wrote:
> Is there a way to know which task has a particular (struct semaphore *)
> down()ed, leading to another task's down() blocking on it?

I would add a field to struct semaphore that tracks the current process.
In your various up and downs have that field tracks the "current" process. 

Do you know what semaphore it is?

This way you dump the semaphore you can see what task it is holding
it.  Have the module dump the semaphore and you can id the task
 
> It would be helpful to get a kernel stacktrace for the culprit too.

Have you tried sysrq t?  See the Documentation/sysrq.txt file.
 
How stuck is the system? 

Keith
