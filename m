Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267516AbSLLW4Y>; Thu, 12 Dec 2002 17:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267526AbSLLW4Y>; Thu, 12 Dec 2002 17:56:24 -0500
Received: from smtp.comcast.net ([24.153.64.2]:6610 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S267516AbSLLWzu>;
	Thu, 12 Dec 2002 17:55:50 -0500
X-URL: genehack.org
Date: Thu, 12 Dec 2002 18:03:36 -0500
From: jacobs@genehack.org (John S. J. Anderson)
Subject: crash when calling madvise( MADV_WILLNEED )
To: linux-kernel@vger.kernel.org
Message-id: <87d6o64z7b.fsf@mendel.genehack.org>
Organization: genehackCorps
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_E6wweEjzjUI0hlnPwQEnYA)"
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2 (i386-pc-linux-gnu)
X-Attribution: john
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_E6wweEjzjUI0hlnPwQEnYA)
Content-type: TEXT/PLAIN
Content-transfer-encoding: 7BIT


  A developer that I support has discovered that the attached code is
  capable of crashing many late series 2.4.x kernels, including
  2.4.20. The easiest way to reproduce this crash is to compile the
  attached code, and call it via 'madvise_test 3 FILE', where FILE is
  a data file of at least 1.5 GB. The contents of FILE don't seem to
  matter. The crash may happen more quickly if multiple copies of the
  program are started. Sometimes the process locks up the terminal it
  is running in; sometimes the kernel throws an OPPS and the whole
  machine goes down. There doesn't seem to be a pattern as to which
  event happens when. 

  This has been observed on both a Dell 8450 (8 CPU, 8 gig RAM) and a
  Dell 1650 (2 CPU, 2 gig RAM). I've also included an oops that we
  captured.

  Thanks for any help. 


--Boundary_(ID_E6wweEjzjUI0hlnPwQEnYA)
Content-type: message/external-body; access-type=local-file;
 name*=us-ascii''~%2ftmp%2fmadvise_test.c

Content-Type: text/x-csrc
Content-ID: <87bs3q4z7b.fsf@mendel.genehack.org>
Content-Transfer-Encoding: binary



--Boundary_(ID_E6wweEjzjUI0hlnPwQEnYA)
Content-type: message/external-body; access-type=local-file;
 name*=us-ascii''~%2ftmp%2fopps

Content-Type: text/plain
Content-ID: <87adja4z7b.fsf@mendel.genehack.org>
Content-Transfer-Encoding: binary



--Boundary_(ID_E6wweEjzjUI0hlnPwQEnYA)
Content-type: TEXT/PLAIN
Content-transfer-encoding: 7BIT



john.
-- 
"[L]iberty of the press is the right of the lonely pamphleteer who
uses carbon paper or a mimeograph just as much as of the large
metropolitan publisher who utilizes the latest photocomposition
methods."- judge's decision in Branzburg v. Hayes

--Boundary_(ID_E6wweEjzjUI0hlnPwQEnYA)--
