Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbVIHPAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbVIHPAM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbVIHPAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:00:12 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:56101 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932525AbVIHPAK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:00:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sUAJj9Jk35uE0v1AsZDHvqGnDti8dCxteNAl1lqiLVruvRP/aygsDG3ajnztOrij8TtbQwGA/Dg7Z/QZZPpFzK8zdYD3uKYjZgXZDQAeFfRCom01wilBFcGiJTKNFbZGuFb0K6kps9taRel30rbwMFbWDrYhVekvC4HOtxpdV8Q=
Message-ID: <dbe377e7050908080010dc23b8@mail.gmail.com>
Date: Thu, 8 Sep 2005 20:30:09 +0530
From: Adhiraj Joshi <adhiraj.m@gmail.com>
Reply-To: adhiraj.m@gmail.com
To: linux-kernel@vger.kernel.org
Subject: A query regarding an entry in Andrew Morton's "must fix" list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
  
  There was a bug some time back in a Must-Fix list regarding UDP
applications going in dead lock.
  (http://kernel.org/pub/linux/kernel/people/akpm/must-fix/must-fix-2.txt )
  Here is an extract:
--------------------------------------------------------------------------------------------------------------
- UDP apps can in theory deadlock, because the ip_append_data path can end
  up sleeping while the socket lock is held.

  It is OK to sleep with the socket held held, normally.  But in this case

  the sleep happens while waiting for socket memory/space to become

  available, if another context needs to take the socket lock to free up the
  space we could hang.
----------------------------------------------------------------------------------------------------------------
Is the fix present in the kernel now? I faced a problem similar to this one.
 
 Thanks in advance,
 Adhiraj.
