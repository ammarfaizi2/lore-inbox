Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbTH2HGJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 03:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbTH2HGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 03:06:09 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.36.229]:9359 "EHLO
	ms-smtp-01.texas.rr.com") by vger.kernel.org with ESMTP
	id S264437AbTH2HGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 03:06:07 -0400
Message-ID: <3F4EFB55.8090300@austin.rr.com>
Date: Fri, 29 Aug 2003 02:05:57 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ->pid in filesystem code
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes the cifs vfs code was using current->pid in multiple places and in 
about five of the places the meaning
really was process id,  and thus presumably better to change this to 
current->tgid.   I have made the change
from pid to tgid for those places in the bk tree for the cifs vfs 
(http://cifs.bkbits.net/linux-2.5cifs) and will try them out.

The locking tests needed to be rerun anyway.

