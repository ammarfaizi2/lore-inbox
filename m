Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A2EC07E96
	for <io-uring@archiver.kernel.org>; Sun, 11 Jul 2021 22:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D73F60C3F
	for <io-uring@archiver.kernel.org>; Sun, 11 Jul 2021 22:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhGKWH4 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 11 Jul 2021 18:07:56 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:56166 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhGKWHz (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 11 Jul 2021 18:07:55 -0400
Received: by mail-io1-f71.google.com with SMTP id i13-20020a5d88cd0000b02904e5ab8bdc6cso10284967iol.22
        for <io-uring@vger.kernel.org>; Sun, 11 Jul 2021 15:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=MLkBS3KT/C1xWdnQv4mpgem4i/D3ft2NwGzrdexe+l4=;
        b=rRi1lBlfbZY/h2d/BaXPO1Sqrpf6aoc1HyaZMwzjyWtWAm6nXIW1tLdeat3VLAYGrc
         uw+2/Mrxsdg238PqeQ6umO0xaAITrk+kSIJQbrqlLuWa+J8Kck2//RxvC4slilWKBxW2
         YHo3NOZQvjx2pc4g6b0jy3i2NzLFFHoohxSpgLqkMF0XvOCk7Cgs2ARAMj6/EiKE5Nkw
         Imuu/iZG9fUN9yMZZCVYG3m3GS/MTMRT1ASQqgk9xP3xL4ekLmPrE+lds8c9qEez4qtJ
         sga64KIQQpquDvQEFW8pvmXC/fPtDqhgj0TRVaSwHVoi5BFHctl5sk1tbHIiN0f/Lb3r
         eW3A==
X-Gm-Message-State: AOAM532EhTqtSMN2K2uZSXE3FVds51iYdBpB7YYU8Cdd3ygXwdTpFzQA
        HyezydHfd8DN9Gd8tXj2h6TgmhkLs56bfLFSD+3ZyN8nmQxC
X-Google-Smtp-Source: ABdhPJxQEaFbT8ZPZ5vkDb06CFAtXVfmVLqYpkYhIJ+dgydxAHWEByp1j5TtQDHamkf8o2ezJNsadfWZyoW8JNFdcM3zJRUQhGhW
MIME-Version: 1.0
X-Received: by 2002:a5d:9958:: with SMTP id v24mr36817517ios.4.1626041108475;
 Sun, 11 Jul 2021 15:05:08 -0700 (PDT)
Date:   Sun, 11 Jul 2021 15:05:08 -0700
In-Reply-To: <f58dd424-b33b-ebaf-b38c-235bd42b643f@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9315305c6e032ee@google.com>
Subject: Re: [syzbot] INFO: task hung in io_uring_cancel_generic
From:   syzbot <syzbot+ba6fcd859210f4e9e109@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ba6fcd859210f4e9e109@syzkaller.appspotmail.com

Tested on:

commit:         66af6ccf io_uring: fix io_drain_req()
git tree:       https://github.com/isilence/linux.git drain_fix_syztest
kernel config:  https://syzkaller.appspot.com/x/.config?x=c650d78cfe48974c
dashboard link: https://syzkaller.appspot.com/bug?extid=ba6fcd859210f4e9e109
compiler:       

Note: testing is done by a robot and is best-effort only.
