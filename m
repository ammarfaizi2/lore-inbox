Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUKXOQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUKXOQP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbUKXOOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:14:06 -0500
Received: from zeus.kernel.org ([204.152.189.113]:57819 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262727AbUKXOFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 09:05:30 -0500
Date: Wed, 24 Nov 2004 15:05:15 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: file as a directory
In-Reply-To: <1101287762.1267.41.camel@pear.st-and.ac.uk>
Message-ID: <Pine.LNX.4.53.0411241501080.2693@yvahk01.tjqt.qr>
References: <2c59f00304112205546349e88e@mail.gmail.com>  <41A1FFFC.70507@hist.no>
 <41A21EAA.2090603@dbservice.com>  <41A23496.505@namesys.com>
 <1101287762.1267.41.camel@pear.st-and.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I think something like
>
>/etc/passwd/[username]
>
>would be a really nice extension. The idea is more general, it would
>unify the namespace for file selection and part-of-file selection.

Yeah, and where will you do that? (Possible answers are: kernel space, user
space).

I honestly vote against *these* kinds of plugins (i.e. reading .tar files,
/etc, and such). For one, it is to be done in kernel space, which means the
module code can not be swapped out. Debugging is more complex, segfaults will
kill the machine -- thus it's more open to blackhat hackers.

Also simply because it (the module code) would be a reinvention of wheel, it's
all been written before.




Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
