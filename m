Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266660AbUF3MvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266660AbUF3MvK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 08:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266661AbUF3MvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 08:51:10 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:5562 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S266660AbUF3MvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 08:51:07 -0400
Message-ID: <40E2B795.35EA5824@bull.net>
Date: Wed, 30 Jun 2004 14:52:37 +0200
From: Jacky Malcles <Jacky.Malcles@bull.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr-FR,fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: A question about extended attributes of filesystem objects (setfattr 
 command)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question regarding
 Attributes of symlinks vs. the files pointed to

If I try to attach name:value pair to object symlink file
then I'll get: "Operation not permitted"

reading the man pages of setfattr (or attr) I thought that it operates
on the attributes of  the  symbolic link itself.

show:
-----
touch f
ln -s f l
setfattr -n user.filename -v ascii1 f l
setfattr -h -n user.filename  -v ascii2 f
getfattr -d f l
setfattr -h -n user.filename  -v ascii3 l
setfattr -h --no-dereference -n user.filename  -v ascii4 l
getfattr -d f l

so, my question is : what is expected ?
I've
libattr-devel-2.2.0-1
libattr-2.2.0-1
attr-2.2.0-1
and  a 2.6.7 kernel

many thanks,
regards,

-- 
 Jacky Malcles    	     B1-403   Email : Jacky.Malcles@bull.net
 Bull SA, 1 rue de Provence, B.P 208, 38432 Echirolles CEDEX, FRANCE
 Tel : 04.76.29.73.14
