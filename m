Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030621AbWKOUGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030621AbWKOUGp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 15:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030653AbWKOUGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 15:06:45 -0500
Received: from wx-out-0506.google.com ([66.249.82.234]:26815 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030621AbWKOUGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 15:06:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CCGAjeAaACPVEA2ty67i3bcL7U6XOBwr5QFf96DMPaMSfM0QHvVG2PHOnTyQ1yR6yxschI4OYakF09OToYO0LilNKrA0u1tMu9fpAffaebYv3x35Tq5B09fDlmAlNUIRv4fDGRZn6IZMIeaqvizZXQIH6IhriMFo9QZgJDtC2w0=
Message-ID: <f36b08ee0611151206k50284ef9n43d7edf744ae2f19@mail.gmail.com>
Date: Wed, 15 Nov 2006 22:06:43 +0200
From: "Yakov Lerner" <iler.ml@gmail.com>
To: Kernel <linux-kernel@vger.kernel.org>
Subject: locking sectors of raw disk (raw read-write test of mounted disk)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to make read-write test of the raw disk, and disk has
mounted partitions. Is it possible to lock  range of sectors
of the raw device so that any kernel code that wants to write
to this range will sleep ? (so that test
    { lock range; read /dev/hda->buf; write buf->/dev/hda; unlock }
won't corrupt the filesysyem ?)

Thanks
Yakov
