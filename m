Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966008AbWKIOFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966008AbWKIOFQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 09:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966009AbWKIOFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 09:05:15 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:7084 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S966008AbWKIOFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 09:05:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cvLh/+cJM/28Yh3fEuVvA8nWEHOXvQEjK6zgxiJtAzInGnixvW0fpj//6T8CYTEzOqI9JeVl+dtz7OY5Y6p89nlNjqOpno5ZQoGG0UXEZXeuwZ6a058Tbo7fNlnMK80kea+/+jLvyMmLrN+fIygqDlfL5Oz+GDfmIEvy6UtOCug=
Message-ID: <5495c4e80611090605t3e2d22e5wd9ea9957cdb2ba1f@mail.gmail.com>
Date: Thu, 9 Nov 2006 22:05:13 +0800
From: "Yi Wang" <wymaillist@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: About dev_queue_xmit
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all!
    I'm reading O'Reilly's <<Understanding Linux Network Internals>>
while reading some kernel codes, I've got a question.
    Linux provide QoS using Traffic Control, and I think mostly QoS is
not enabled(right?). When QoS is disabled, does Traffic Control works?
The correspoding kernel code:

int dev_queue_xmit(struct sk_buff *skb){
...
if (q->enqueue) {...
	}
...
}
    I think by default(without QoS support), q->enqueue should be true
except for the no queue devices(software devices), is it right? If so,
is the schedule policy of the queue FIFO?

    I'm just not sure about this...

best regards
Leonid
