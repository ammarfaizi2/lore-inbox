Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWD0SdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWD0SdE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 14:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWD0SdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 14:33:04 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:63775 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964950AbWD0SdC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 14:33:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WWdczO4qIbsP89mtU7ceitDsQK+yeJjre0UesO7MCLfLs+UE47h4JbNUZDiff2fJhdCmVms92szQs1ZboL2sXe6oPxCQkD0VImOncwC16Ij4vzi9YVp2Nlu9X5r9J/4P+RYFzEIz2/KcOvHJv3RCFdrj9mr6BYTwkxazCYJPa8g=
Message-ID: <4ae3c140604271132u1f2db743t20aeb94993938086@mail.gmail.com>
Date: Thu, 27 Apr 2006 14:32:57 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Why the RPC task structure adds a new field "tk_count"?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I migrate from 2.6.11 to 2.6.16, but found that a new field tk_count
was added to the rpc task structure. In function rpc_release_task(), I
saw the following code:

	if (!atomic_dec_and_test(&task->tk_count))
		return;


Looks like a task can be reused or refered multiple times? What's the
theory behind this? Why do we need this?

Thanks,

Xin
