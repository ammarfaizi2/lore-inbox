Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbULJJzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbULJJzA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 04:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbULJJzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 04:55:00 -0500
Received: from web41402.mail.yahoo.com ([66.218.93.68]:19029 "HELO
	web41402.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261171AbULJJy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 04:54:56 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=nL/r4t8Mq7qTO8wVmH6gwO4Y5kVzeEWaOH6QCqTNr6FYyO04JJf1Ds+ILH/a4zHHDQPD2/8tCAVUVSzjTwtFp8DEj4z7LM4mME58fijncBKV+aRxyXzQLL9b1tnI5SxpqMKvP8VXd3vhn9xChUREoIbBTaN2mD4bcTIuqrsoSq0=  ;
Message-ID: <20041210095455.62156.qmail@web41402.mail.yahoo.com>
Date: Fri, 10 Dec 2004 01:54:55 -0800 (PST)
From: cranium2003 <cranium2003@yahoo.com>
Subject: analysing ip_rcv code problems
To: kernerl mail <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
                I know that in kernel 2.4 series,
function used to receive IP packets is ip_rcv. But i
am not getting where exactly IP header is removed that
is following lines from function ip_rcv can be used to
remove IP header                                      
                                                      
                                                      
                                                      
                                                      
                                                      
                                                      
                              if (!pskb_may_pull(skb,
sizeof(struct iphdr)))                                
                                                    
goto inhdr_error;                                     
                                                      
      iph = skb->nh.iph;                              
                                                      
                                                      
                                                      
                          ...                         
                                                      
                                        ...           
                                                      
                                                     
...                                                   
                                                      
              ...                                     
                                                      
                                             and also
following lines from same kernel is used to remove
header as IP
header length is 20 bytes then which function actually
does IP header removal.                               
                      if (!pskb_may_pull(skb,
iph->ihl*4))                                          
                                                    
goto inhdr_error;                                     
                                                      
                                                      
                                                      
                    iph = skb->nh.iph;                
                                                      
                                                      
                                                      
                                                      
Also why iph = skb->nh.iph statement is used twice in
function code ip_rcv.                                 
                                                      
                                                      
              regards,                                
                                                      
                            cranium.


		
__________________________________ 
Do you Yahoo!? 
Send holiday email and support a worthy cause. Do good. 
http://celebrity.mail.yahoo.com
