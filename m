Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289968AbSAWTCO>; Wed, 23 Jan 2002 14:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289971AbSAWTCE>; Wed, 23 Jan 2002 14:02:04 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:50602 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289968AbSAWTBz>; Wed, 23 Jan 2002 14:01:55 -0500
Subject: Re: [PATCH *] rmap VM, version 12
To: riel@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFB07135FF.E6C5BE7E-ON88256B4A.0068CB3F@boulder.ibm.com>
From: "Badari Pulavarty" <badari@us.ibm.com>
Date: Wed, 23 Jan 2002 11:02:37 -0800
X-MIMETrack: Serialize by Router on D03NM044/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 01/23/2002 12:01:44 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does this explain why my SMP box does not boot with rmap12 ? It works fine
with rmap11c.

Machine: 4x  500MHz Pentium Pro with 3GB RAM

When I tried to boot 2.4.17+rmap12, last message I see is

uncompressing linux ...
booting ..


Thanks,
Badari



                                                                                                         
                    "David S.                                                                            
                    Miller"              To:     riel@conectiva.com.br                                   
                    <davem@redhat.       cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org        
                    com>                 Subject:     Re: [PATCH *] rmap VM, version 12                  
                    Sent by:                                                                             
                    owner-linux-mm                                                                       
                    @kvack.org                                                                           
                                                                                                         
                                                                                                         
                    01/23/02 10:44                                                                       
                    AM                                                                                   
                                                                                                         
                                                                                                         



     - use fast pte quicklists on non-pae machines           (Andrea
Arcangeli)

Does this work on SMP?  I remember they were turned off because
they were simply broken on SMP.

The problem is that when vmalloc() or whatever kernel mappings change
you have to update all the quicklist page tables to match.

Andrea probably fixed this, I haven't looked at the patch.
If so, ignoreme.
--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/




