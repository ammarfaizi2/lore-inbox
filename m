Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263966AbSJ3FLK>; Wed, 30 Oct 2002 00:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbSJ3FLJ>; Wed, 30 Oct 2002 00:11:09 -0500
Received: from relay.sotline.ru ([80.89.139.226]:4101 "EHLO relay.sotline.ru")
	by vger.kernel.org with ESMTP id <S263966AbSJ3FLJ>;
	Wed, 30 Oct 2002 00:11:09 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Anton Petrusevich <casus@att-ltd.biz>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre11: file handle leak or too much delayed deallocation?
Date: Wed, 30 Oct 2002 11:18:11 +0600
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210301118.11383.casus@att-ltd.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

# cat /proc/sys/fs/file-nr
218374  17929   1000000

This looks wrong to me. I am constantly increasing /proc/sys/fs/file-max 
because of "Too many open files in system" error in application. Application 
itself doesn't have file handle leak: it's multi-processes(not threads) based 
and the main process doesn't open any socket, only children do and they don't 
live for long. 
-- 
Anton Petrusevich
