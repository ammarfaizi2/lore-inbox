Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285970AbRLHV1W>; Sat, 8 Dec 2001 16:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285971AbRLHV1D>; Sat, 8 Dec 2001 16:27:03 -0500
Received: from smtp01.uc3m.es ([163.117.136.121]:14863 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S285970AbRLHV0z>;
	Sat, 8 Dec 2001 16:26:55 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200112082126.WAA10376@nbd.it.uc3m.es>
Subject: porting howto for 2.5?
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Sat, 8 Dec 2001 22:26:48 +0100 (CET)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I'm beat for the night.

   io_request_lock disappeared. OK, so apparently I'm now supposed
   to use the queue lock.

   req->cmd is now an array. OK, so I really wanted the direction of
   the req, so I used rq_data_dir, which looks at the req->flags.
   But what are the flags for? I need space on a req to hold a
   "sequence number". Doesn't matter if it wraps. Just has to be
   valid for 10s. What is the cmd array an array OF?

   buffer heads have gone! Now there are "bio"s. Boo hoo .. just 
   when I was really getting good with buffer_head. How do I
   copy stuff to/from user space from a bio!? It seems to contain
   bio_vecs. 

Is there a 2.4-2.5 porting howto beginning to be developed somewhere?
Please?

How can one man do such damage in just one version increment :-)?

Peter
