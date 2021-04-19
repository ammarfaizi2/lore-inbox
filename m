Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB891C433B4
	for <io-uring@archiver.kernel.org>; Mon, 19 Apr 2021 15:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0700611CE
	for <io-uring@archiver.kernel.org>; Mon, 19 Apr 2021 15:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbhDSPCf (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:02:35 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:57328 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240663AbhDSPCf (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 19 Apr 2021 11:02:35 -0400
Received: by mail-io1-f70.google.com with SMTP id y20-20020a6bd8140000b02903e6787c4986so4876235iob.23
        for <io-uring@vger.kernel.org>; Mon, 19 Apr 2021 08:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WMrYoKskNr7U70R71k3smKLM3Le7PTj2L2OFTVziLOM=;
        b=DetL7RqYihva8kV+Yhj8XB5oSvinPo7BDUndiFA19wbM3mW9TGM/VjRI2LXFynPdop
         UVglUWTH0tvHiQfBwoJ9zTdUmsZCAZjcaxICXM7cTMjczHh4S4oid/C+pfSa2x7Zr40L
         MsxgT0MPYhM3fJrxNAUOicAkT8P0Fwl2iHQfUmyY4rI+Zp2i2gNV+NblzdNRZBV2dN/3
         YMBFTbt1LoR2iaDtVv83w05vxcyhNBsKke/aOotpJ3jSDQH1fdH21ly7aSx4uxe9Rzg+
         0n5lvbjbYwPvfkPnTAS1XcmE9HGGOOp8It3ds9yGYQpmaq3ALXyIRdZq+iCPgXRsHpLw
         XS8w==
X-Gm-Message-State: AOAM531BrfOQLJGvv9mS+w2ssJ33xjHLWHcBxcxz+0WVTRP+5GpLoWlj
        fQGp+ghAIYFvznDnzoqGnNxnFf+wSdVBC884Ps608T4YocjF
X-Google-Smtp-Source: ABdhPJxYspjPxbt+oEACm+W93vLXmTGM6mpe1oQlCLjG/LKWOtqLnPpBqJY/Q6iaKq+tNonPoDwvDyRgWFknhroP/xGQrazCyEeB
MIME-Version: 1.0
X-Received: by 2002:a02:1c07:: with SMTP id c7mr16825882jac.111.1618844524745;
 Mon, 19 Apr 2021 08:02:04 -0700 (PDT)
Date:   Mon, 19 Apr 2021 08:02:04 -0700
In-Reply-To: <c12b0100-50be-907b-503d-3aa00223194c@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc7eb305c0549c1a@google.com>
Subject: Re: [syzbot] WARNING in __percpu_ref_exit (2)
From:   syzbot <syzbot+d6218cb2fae0b2411e9d@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, hdanton@sina.com,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d6218cb2fae0b2411e9d@syzkaller.appspotmail.com

Tested on:

commit:         75c4021a io_uring: check register restriction afore quiesce
git tree:       git://git.kernel.dk/linux-block for-5.13/io_uring
kernel config:  https://syzkaller.appspot.com/x/.config?x=1dfd9a1e63100694
dashboard link: https://syzkaller.appspot.com/bug?extid=d6218cb2fae0b2411e9d
compiler:       

Note: testing is done by a robot and is best-effort only.
