Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWHaE3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWHaE3s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 00:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWHaE3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 00:29:48 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:18888 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751119AbWHaE3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 00:29:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZQe+ihXTqhNRlUoAjaoTa0UqUHz/KMHWI/Fgo8h5ZWX9g4y2oMuZiHTEGQYLnkE1Rf/o1AzLM3Hw3MDx9Lr3Pr8qfS8kB/NSonCbQyQfKlpH/aZEeGK9sUSrkGNriHkkOJL9U/fH3p9im8mDf0r1WjGTI9nu8y6Qy4ryCrFVuY8=
Message-ID: <309a667c0608302129o55cdc88bt9e57683a9e5fa253@mail.gmail.com>
Date: Thu, 31 Aug 2006 09:59:47 +0530
From: "Devesh Sharma" <devesh28@gmail.com>
To: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Question about Atomic operations
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arjan and list,

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
