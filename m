Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129477AbQK1BN6>; Mon, 27 Nov 2000 20:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129575AbQK1BNt>; Mon, 27 Nov 2000 20:13:49 -0500
Received: from hera.cwi.nl ([192.16.191.1]:2733 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S129477AbQK1BNm>;
        Mon, 27 Nov 2000 20:13:42 -0500
Date: Tue, 28 Nov 2000 01:43:40 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Jörg Schütter 
        <joerg_schuetter@heraeus-infosystems.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.0-test11: _isofs_bmap: block < 0
Message-ID: <20001128014340.A9220@veritas.com>
In-Reply-To: <20001127210912.A1051@mars.linux.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001127210912.A1051@mars.linux.priv>; from joerg_schuetter@heraeus-infosystems.com on Mon, Nov 27, 2000 at 09:09:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 09:09:12PM +0100, Jörg Schütter wrote:

> after upgrading from test9 to test11, skipping test 10, I get 
> the messages "_isofs_bmap: block < 0", "_isofs_bmap: block < ..."
> which also means I can't read the cd.

A FAQ. Remove the two lines

-       if (filp->f_pos >= inode->i_size)
-               return 0;

from fs/isofs/dir.c around line 118.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
