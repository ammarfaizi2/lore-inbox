Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S133072AbQK0ADz>; Sun, 26 Nov 2000 19:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S133081AbQK0ADq>; Sun, 26 Nov 2000 19:03:46 -0500
Received: from hera.cwi.nl ([192.16.191.1]:65204 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S133072AbQK0ADa>;
        Sun, 26 Nov 2000 19:03:30 -0500
Date: Mon, 27 Nov 2000 00:33:18 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Stefan Frings <stefan@edv-frings.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: cannot ls cdroms (_isofs_bmap block >= EOF)
Message-ID: <20001127003318.A7749@veritas.com>
In-Reply-To: <00112700180300.08780@notebook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <00112700180300.08780@notebook>; from stefan@edv-frings.de on Mon, Nov 27, 2000 at 12:16:41AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 12:16:41AM +0100, Stefan Frings wrote:
> [1.] One line summary of the problem:  
> 
> cannot ls cdroms (_isofs_bmap block >= EOF)

Yes, a well-known problem.
Delete two lines around line 118 of fs/isofs/dir.c:

-       if (filp->f_pos >= inode->i_size)
-               return 0;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
