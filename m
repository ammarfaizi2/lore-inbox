Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262810AbTCJIqF>; Mon, 10 Mar 2003 03:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262811AbTCJIqF>; Mon, 10 Mar 2003 03:46:05 -0500
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:36259 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S262810AbTCJIqD>; Mon, 10 Mar 2003 03:46:03 -0500
Importance: Normal
Sensitivity: 
Subject: Re: Fwd: [PATCH] s390 (1/7): s390 arch fixes.
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFCD7A3F6E.6326D41F-ONC1256CE5.0030B7EF@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 10 Mar 2003 09:55:12 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 10/03/2003 09:56:28
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Are you sure it's not "last = resume(prev, next);"?
>
> -- Pete

switch_to is called in context_switch as follows:

      switch_to(prev, next, prev);

At the moment it doesn't matter but thinking about the
meaning of the parameter names your are probably right.
This should better be last = resume(prev, next).

blue skies,
   Martin


