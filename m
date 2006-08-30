Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbWH3FtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWH3FtI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 01:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbWH3FtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 01:49:08 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:26763 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751529AbWH3FtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 01:49:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TSzBk1mNa979PZTXLUC300z6lOgoOa95Rhe0UNwryz4nmAir5vExx3N+QOpp+pR8HSeP6vYIis2wWs/0VpStgXAwWNVmKhMZIJgvqRVZt+4xtPJG3yMaQBjSu3UNfg4e+60e7tf4syNpZWU/7HyMNmRjkkmSQtgTsUWJtsGhmUM=
Message-ID: <309a667c0608292249y3a5173a1uc815cf5e265d332c@mail.gmail.com>
Date: Wed, 30 Aug 2006 11:19:00 +0530
From: "Devesh Sharma" <devesh28@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Question on Atomic operations
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

The documentation related to atomic operations says that the following
functions should be called in SMP safe maner

 void atomic_add(int i, atomic_t *v);
 void atomic_sub(int i, atomic_t *v);
 void atomic_inc(atomic_t *v);
 void atomic_dec(atomic_t *v);

since the implementation of these functions are prefixed with LOCK
prefix (On i386 arch.) which either asserts LOCK# signal or performs
cache locking which gauarentees coherency.

Then why these functions should be called in SMP safe manner?
