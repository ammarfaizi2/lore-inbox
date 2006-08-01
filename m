Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751789AbWHASyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbWHASyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbWHASyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:54:39 -0400
Received: from ns2.suse.de ([195.135.220.15]:23491 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751789AbWHASyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:54:39 -0400
To: Amit Gud <agud@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] sysctl for the latecomers
References: <44CF69F0.6040801@redhat.com>
From: Andi Kleen <ak@suse.de>
Date: 01 Aug 2006 20:54:37 +0200
In-Reply-To: <44CF69F0.6040801@redhat.com>
Message-ID: <p738xm82snm.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit Gud <agud@redhat.com> writes:

> /etc/sysctl.conf values are of no use to kernel modules that are
> inserted after init scripts call sysctl for the values in
> /etc/sysctl.conf

_sysctl(2) is obsolete and on its way out. Doesn't make sense
to add new feature to it.

BTW I doubt the sysctl user program actually uses it - most likely
it uses /proc/sys

I think I agree with hpa that this feature belongs into modprobe
if anywhere.

-Andi
