Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA96C433B4
	for <io-uring@archiver.kernel.org>; Fri, 14 May 2021 01:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B4C6143D
	for <io-uring@archiver.kernel.org>; Fri, 14 May 2021 01:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhENBGW (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 13 May 2021 21:06:22 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:37796 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhENBGV (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 13 May 2021 21:06:21 -0400
Received: by mail-il1-f198.google.com with SMTP id r13-20020a92cd8d0000b02901a627ef20a2so23558350ilb.4
        for <io-uring@vger.kernel.org>; Thu, 13 May 2021 18:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WyhwVb/2nAKSCjZePQHr7y74mXP0pKdra5nG2NU9qyo=;
        b=EyAjhXoKrQU1/I5SMUf1JqXtIAKBAUqktY1T1t8UPct9yo5397jvd0gH53g0VqqAsb
         X8IKZ8UTj1VpMQV4/Ur/aPW7IiJLGRUWQuaEmcvfS6E4kjOIy72/VY9eBZlVerzSZDQf
         c4tRSl1zKCgV4tsWEcIWM0PMsvFhkXZR9eA6R2d+k6F107cZ7WGu12DUvjUN7CoPuouF
         AeadiAriojf1AaH3lSUHBS0LVk/r1kibO9zUr6+A7BTCuMnAjupycthAXrTyrjsM/Z81
         +0He9kgXsWOoGOB9JdR8hCwqtTPR6HPHy1D1xGezYk6T3hpXscuXGiB+mfQubnX5B3vX
         dTcA==
X-Gm-Message-State: AOAM530nD9E2tqpbiK0zxjmyQUPnllGGURC08PxOAqZgHsepc92cSOnb
        KpupMO+3c+T6BktEc2RwwkN8Cx45M/zAFcK0y1TXqWFzD28v
X-Google-Smtp-Source: ABdhPJzQ/Z36cpwXZM75ay+7M7e7JrJdMP6eFRSLZrA/471M4WuQmbzCyB4PZILkNutR+YB8DeBbVbSICSoaUPSnk/lGLMld8n6k
MIME-Version: 1.0
X-Received: by 2002:a02:cac6:: with SMTP id f6mr40166255jap.118.1620954311158;
 Thu, 13 May 2021 18:05:11 -0700 (PDT)
Date:   Thu, 13 May 2021 18:05:11 -0700
In-Reply-To: <314c4ece-d8c1-2d13-804b-3652488d09de@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9f47605c23fd526@google.com>
Subject: Re: [syzbot] WARNING in io_link_timeout_fn
From:   syzbot <syzbot+5a864149dd970b546223@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5a864149dd970b546223@syzkaller.appspotmail.com

Tested on:

commit:         b580b3d6 io_uring: always remove ltimeout on cb run
git tree:       https://github.com/isilence/linux.git syz_test8
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae2e6c63d6410fd3
dashboard link: https://syzkaller.appspot.com/bug?extid=5a864149dd970b546223
compiler:       

Note: testing is done by a robot and is best-effort only.
