Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314132AbSDZTTi>; Fri, 26 Apr 2002 15:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314136AbSDZTTh>; Fri, 26 Apr 2002 15:19:37 -0400
Received: from zero.tech9.net ([209.61.188.187]:33298 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314132AbSDZTTh>;
	Fri, 26 Apr 2002 15:19:37 -0400
Subject: Re: spinlocking between user context / tasklet / tophalf question
From: Robert Love <rml@tech9.net>
To: Emmanuel Michon <emmanuel_michon@realmagic.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7wwuuu4zam.fsf@avalon.france.sdesigns.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 26 Apr 2002 15:19:35 -0400
Message-Id: <1019848780.2045.617.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-04-26 at 04:52, Emmanuel Michon wrote:

> 1. Should I use spin_lock(&Y_lock); or spin_lock_bh(&Y_lock); in the tasklet
> body?

You would want to use spin_lock_bh to serialize against other softirqs. 
That does not seem to be a need, here.

> 2. What is the reality behind: ``things which sleep'', is it really a problem
> to use copy_from_user/copy_to_user holding a spinlock?

Yes, they sleep.

	Robert Love

