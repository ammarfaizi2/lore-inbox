Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030590AbWJKQ7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030590AbWJKQ7o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWJKQ7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:59:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52661 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030590AbWJKQ7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:59:43 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: safe_smp_processor_id i386 and x86_64
References: <eg60ej$qqe$1@sea.gmane.org>
Date: Wed, 11 Oct 2006 10:58:21 -0600
In-Reply-To: <eg60ej$qqe$1@sea.gmane.org> (Aneesh Kumar K. V.'s message of
	"Fri, 06 Oct 2006 22:02:17 +0530")
Message-ID: <m1y7rmlrgy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@gmail.com> writes:

> I was looking at the git log and the below changes confused me.

They are being used to solve different problems.
smp_processor_id on i386 doesn't work when a stack overflow
occurs. safe_smp_processor_id does.

On x86_64 since it is a simple register value we don't have that problem.

Eric
