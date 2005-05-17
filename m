Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVEQLZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVEQLZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 07:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVEQLYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 07:24:55 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:17318 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261395AbVEQLVz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 07:21:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=d4YhsvwwHfT/NBbhPnKXjSNwkXnGIQH8iES47TA1fxg5aL426q2/8uCEEnF5V8g8j8XYlGfHGwwXFmfWjHm/BBKwpSmVqUjceapORACLkhwEadH6gOLJbrGYmumVrgBNhsmvxUwSG62hLoyk88qUItvVCIf2BqQLqF7ktbNAc2s=
Message-ID: <73e1f59805051704216bc4c78f@mail.gmail.com>
Date: Tue, 17 May 2005 13:21:53 +0200
From: =?WINDOWS-1252?Q?Lubo=9A_Dole=9Eel?= <lubosd@gmail.com>
Reply-To: =?WINDOWS-1252?Q?Lubo=9A_Dole=9Eel?= <lubosd@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: "loop device recursion avoidance" patch causes difficulties
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've created a bugreport at http://bugme.osdl.org/show_bug.cgi?id=4472
and I was advised to write to this list.

A patch called "loop device recursion avoidance" which appeared in
2.6.11 kernel has complicated ISO image mounting from another mounted
media.

Example:

# mount /mnt/dvd
# mount -o loop /mnt/dvd/file.iso /somedir

The mount command produces this error: "ioctl: LOOP_SET_FD: Invalid argument".

This operation maybe is a kind of recursion but I think that recursion
should be limited - not disabled.
Now I have to copy the ISO image to my hdd before mounting. I used to
put CD backups on DVDs; now it's more complicated to use.

I am not a "linux-kernel" subscriber so please CC me to: lubosd at gmail com.

Best regards,
Lubos Dolezel
