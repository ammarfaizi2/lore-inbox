Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263391AbTDCOCn>; Thu, 3 Apr 2003 09:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263392AbTDCOCn>; Thu, 3 Apr 2003 09:02:43 -0500
Received: from trappist.elis.rug.ac.be ([157.193.67.1]:28092 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S263391AbTDCOCm>; Thu, 3 Apr 2003 09:02:42 -0500
Date: Thu, 3 Apr 2003 16:14:05 +0200 (CEST)
From: fcorneli@elis.ugent.be
To: linux-kernel@vger.kernel.org
cc: Frank.Cornelis@elis.rug.ac.be
Subject: read actor
Message-ID: <Pine.LNX.4.44.0304031601080.3041-100000@tom.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When one uses do_generic_file_read to (in-kernel) read a file from the 
page cache one has to give a read_actor as parameter. Suppose different 
do_generic_file_read instances occur simultaneously, then how can a 
shared file_read_actor differentiate between the different 
do_generic_file_read instances that made a call to it?
Shouldn't read_descriptor_t contain something like
	void *this_data;
to make this possible?

I also very much could use a this_data field so my read_actor can put the 
data into a structure pointed to by this_data.
If something for this already is present somewhere... please point me to 
that place in the code tree.

Please CC me; I'm not on the list.


Frank.

