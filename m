Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312381AbSFEHgq>; Wed, 5 Jun 2002 03:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSFEHgp>; Wed, 5 Jun 2002 03:36:45 -0400
Received: from argo.anu.edu.au ([150.203.5.57]:23681 "HELO argo.anu.edu.au")
	by vger.kernel.org with SMTP id <S312381AbSFEHgp> convert rfc822-to-8bit;
	Wed, 5 Jun 2002 03:36:45 -0400
From: "Roger W. Brown" <bregor@anusf.anu.edu.au>
Reply-To: bregor@anusf.anu.edu.au
Organization: Australian National University
To: linux-kernel@vger.kernel.org
Subject: Definition conflict in 2.4.19-pre?? code
Date: Wed, 5 Jun 2002 17:36:45 +1000
User-Agent: KMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200206051736.45920.bregor@sf.anu.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi,

      I am not able to compile 2.4 series kernels after
  linux-2.4.19-pre1 and I don't understand how others can !

  Consider the "struct request_queue" definition in blkdev.h

  In the 2.4.19-pre1 version, the last few lines read:
        /*
         * Tasks wait here for free read and write requests
         */
        wait_queue_head_t       wait_for_requests[2];
  };
  and for later versions this is changed to:
        /*
         * Tasks wait here for free request
         */
        wait_queue_head_t       wait_for_request;
  };

  yet drivers/block/ll_rw_blk.c still makes references to
  wait_for_requests[?]  in the void blk_init_free_list()
  and blkdev_release_request() functions and elsewhere.

  Roger

-- 
