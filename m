Return-Path: <linux-kernel-owner+w=401wt.eu-S932913AbWLNVF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932913AbWLNVF7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 16:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932911AbWLNVF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 16:05:59 -0500
Received: from web50104.mail.yahoo.com ([206.190.38.32]:29368 "HELO
	web50104.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932913AbWLNVF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 16:05:58 -0500
Message-ID: <20061214210557.80507.qmail@web50104.mail.yahoo.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=B6KBzKxl60bgimhKMm272CP4a1VVxKiegOLbKzJh+DN6sAg4G+BBDLrLmUsGY6aoOAb0eF7G1Y3BVffulYWNtmI3+rcouVfSpRUVQ2U1qj99+KLZrQcvgIFZXruUfyQnwUaxfLi2QMaKdvW8oFRfTAkFbiYB7OEAMjna2TyjnSo=;
X-YMail-OSG: u4cQ_qsVM1kTzncpaqngizrnl2_lk3yweG9wIueg
Date: Thu, 14 Dec 2006 13:05:57 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: [PATCH 3/3] EDAC: Add Fully-Buffered DIMM APIs to core
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061214105809.4143be6c@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Alan <alan@lxorguk.ukuu.org.uk> wrote:

> 
> > +void edac_mc_handle_fbd_ue(struct mem_ctl_info *mci,
> > +				unsigned int csrow,
> > +				unsigned int channela,
> > +				unsigned int channelb,
> > +				char *msg)
> > +{
> > +	int len = EDAC_MC_LABEL_LEN * 4;
> > +	char labels[len + 1];
> 
> Have you checked gcc generates the right code from this and not a
> dynamic
> allocation. I'm not sure if you want "const int len" to force that ?

good question

I looked at the output for this and the 'edac_c_handle_ue()' function
from which this function was copied, and both adjust the stack pointer
and do not call for dynamic allocation.

An old guy's old method explored.

thanks for the sanity check

doug t


> 
> 
> Otherwise looks ok
> 

