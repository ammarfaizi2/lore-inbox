Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265096AbTLKPKJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 10:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbTLKPKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 10:10:09 -0500
Received: from main.gmane.org ([80.91.224.249]:16529 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265096AbTLKPKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 10:10:04 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
Subject: Re: 2.4.23 + tmpfs: where's my mem?!
Date: Thu, 11 Dec 2003 16:01:08 +0100
Organization: Technische Universitaet Ilmenau, Germany
Message-ID: <bra0rj$qai$1@sea.gmane.org>
References: <20031211133124.GA18161@alpha.home.local> <Pine.LNX.4.44.0312111351520.1386-100000@localhost.localdomain> <yw1x3cbrh1qn.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård <mru@kth.se> wrote:
> Hugh Dickins <hugh@veritas.com> writes:
>> But the strange thing is that df's Used does not match du: they should
>> be identical, though arrived at from different directions.  I've not

No, they are not identical and should not be.

Unlike df, which reads the used counter from the filesystem
meta information, du iterates over files within directories.

If you have a file without a name (created, still open, all
links removed), it does not exist in any directory but it
does exist in the filesystem. So df should show the space
used for it, while du should not.

> FWIW, I've seen this behavior with vmware 4.  The space came back when
> I closed vmware.

This is, what Willy Tarreau described.


regards,
   Mario
-- 
Ho ho ho! I am Santa Claus of Borg. Nice assimilation all together!

